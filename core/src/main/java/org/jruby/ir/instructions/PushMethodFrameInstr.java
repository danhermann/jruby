package org.jruby.ir.instructions;

import org.jruby.RubySymbol;
import org.jruby.ir.IRVisitor;
import org.jruby.ir.Operation;
import org.jruby.ir.persistence.IRReaderDecoder;
import org.jruby.ir.transformations.inlining.CloneInfo;
import org.jruby.ir.transformations.inlining.SimpleCloneInfo;

public class PushMethodFrameInstr extends NoOperandInstr implements FixedArityInstr {
    private final RubySymbol frameName;
    
    public PushMethodFrameInstr(RubySymbol frameName) {
        super(Operation.PUSH_METHOD_FRAME);

        this.frameName = frameName;
    }

    public RubySymbol getFrameName() {
        return frameName;
    }

    @Override
    public Instr clone(CloneInfo ii) {
        return ii instanceof SimpleCloneInfo ? this : NopInstr.NOP;  // FIXME: Is this correct?
    }

    public static PushMethodFrameInstr decode(IRReaderDecoder d) {
        return new PushMethodFrameInstr(d.decodeSymbol());
    }

    @Override
    public void visit(IRVisitor visitor) {
        visitor.PushMethodFrameInstr(this);
    }
}
