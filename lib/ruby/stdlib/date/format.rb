# format.rb: Written by Tadayoshi Funaba 1999-2009
# $Id: format.rb,v 2.43 2008-01-17 20:16:31+09 tadf Exp $

class Date

  module Format # :nodoc:

    MONTHS = {
      'january'  => 1, 'february' => 2, 'march'    => 3, 'april'    => 4,
      'may'      => 5, 'june'     => 6, 'july'     => 7, 'august'   => 8,
      'september'=> 9, 'october'  =>10, 'november' =>11, 'december' =>12
    }.freeze

    DAYS = {
      'sunday'   => 0, 'monday'   => 1, 'tuesday'  => 2, 'wednesday'=> 3,
      'thursday' => 4, 'friday'   => 5, 'saturday' => 6
    }.freeze

    ABBR_MONTHS = {
      'jan'      => 1, 'feb'      => 2, 'mar'      => 3, 'apr'      => 4,
      'may'      => 5, 'jun'      => 6, 'jul'      => 7, 'aug'      => 8,
      'sep'      => 9, 'oct'      =>10, 'nov'      =>11, 'dec'      =>12
    }.freeze

    ABBR_DAYS = {
      'sun'      => 0, 'mon'      => 1, 'tue'      => 2, 'wed'      => 3,
      'thu'      => 4, 'fri'      => 5, 'sat'      => 6
    }.freeze

    ZONES = {
      'ut'  =>  0*3600, 'gmt' =>  0*3600, 'est' => -5*3600, 'edt' => -4*3600,
      'cst' => -6*3600, 'cdt' => -5*3600, 'mst' => -7*3600, 'mdt' => -6*3600,
      'pst' => -8*3600, 'pdt' => -7*3600,
      'a'   =>  1*3600, 'b'   =>  2*3600, 'c'   =>  3*3600, 'd'   =>  4*3600,
      'e'   =>  5*3600, 'f'   =>  6*3600, 'g'   =>  7*3600, 'h'   =>  8*3600,
      'i'   =>  9*3600, 'k'   => 10*3600, 'l'   => 11*3600, 'm'   => 12*3600,
      'n'   => -1*3600, 'o'   => -2*3600, 'p'   => -3*3600, 'q'   => -4*3600,
      'r'   => -5*3600, 's'   => -6*3600, 't'   => -7*3600, 'u'   => -8*3600,
      'v'   => -9*3600, 'w'   =>-10*3600, 'x'   =>-11*3600, 'y'   =>-12*3600,
      'z'   =>  0*3600,

      'utc' =>  0*3600, 'wet' =>  0*3600,
      'at'  => -2*3600, 'brst'=> -2*3600, 'ndt' => -(2*3600+1800),
      'art' => -3*3600, 'adt' => -3*3600, 'brt' => -3*3600, 'clst'=> -3*3600,
      'nst' => -(3*3600+1800),
      'ast' => -4*3600, 'clt' => -4*3600,
      'akdt'=> -8*3600, 'ydt' => -8*3600,
      'akst'=> -9*3600, 'hadt'=> -9*3600, 'hdt' => -9*3600, 'yst' => -9*3600,
      'ahst'=>-10*3600, 'cat' =>-10*3600, 'hast'=>-10*3600, 'hst' =>-10*3600,
      'nt'  =>-11*3600,
      'idlw'=>-12*3600,
      'bst' =>  1*3600, 'cet' =>  1*3600, 'fwt' =>  1*3600, 'met' =>  1*3600,
      'mewt'=>  1*3600, 'mez' =>  1*3600, 'swt' =>  1*3600, 'wat' =>  1*3600,
      'west'=>  1*3600,
      'cest'=>  2*3600, 'eet' =>  2*3600, 'fst' =>  2*3600, 'mest'=>  2*3600,
      'mesz'=>  2*3600, 'sast'=>  2*3600, 'sst' =>  2*3600,
      'bt'  =>  3*3600, 'eat' =>  3*3600, 'eest'=>  3*3600, 'msk' =>  3*3600,
      'msd' =>  4*3600, 'zp4' =>  4*3600,
      'zp5' =>  5*3600, 'ist' =>  (5*3600+1800),
      'zp6' =>  6*3600,
      'wast'=>  7*3600,
      'cct' =>  8*3600, 'sgt' =>  8*3600, 'wadt'=>  8*3600,
      'jst' =>  9*3600, 'kst' =>  9*3600,
      'east'=> 10*3600, 'gst' => 10*3600,
      'eadt'=> 11*3600,
      'idle'=> 12*3600, 'nzst'=> 12*3600, 'nzt' => 12*3600,
      'nzdt'=> 13*3600,

      'afghanistan'           =>   16200, 'alaskan'               =>  -32400,
      'arab'                  =>   10800, 'arabian'               =>   14400,
      'arabic'                =>   10800, 'atlantic'              =>  -14400,
      'aus central'           =>   34200, 'aus eastern'           =>   36000,
      'azores'                =>   -3600, 'canada central'        =>  -21600,
      'cape verde'            =>   -3600, 'caucasus'              =>   14400,
      'cen. australia'        =>   34200, 'central america'       =>  -21600,
      'central asia'          =>   21600, 'central europe'        =>    3600,
      'central european'      =>    3600, 'central pacific'       =>   39600,
      'central'               =>  -21600, 'china'                 =>   28800,
      'dateline'              =>  -43200, 'e. africa'             =>   10800,
      'e. australia'          =>   36000, 'e. europe'             =>    7200,
      'e. south america'      =>  -10800, 'eastern'               =>  -18000,
      'egypt'                 =>    7200, 'ekaterinburg'          =>   18000,
      'fiji'                  =>   43200, 'fle'                   =>    7200,
      'greenland'             =>  -10800, 'greenwich'             =>       0,
      'gtb'                   =>    7200, 'hawaiian'              =>  -36000,
      'india'                 =>   19800, 'iran'                  =>   12600,
      'jerusalem'             =>    7200, 'korea'                 =>   32400,
      'mexico'                =>  -21600, 'mid-atlantic'          =>   -7200,
      'mountain'              =>  -25200, 'myanmar'               =>   23400,
      'n. central asia'       =>   21600, 'nepal'                 =>   20700,
      'new zealand'           =>   43200, 'newfoundland'          =>  -12600,
      'north asia east'       =>   28800, 'north asia'            =>   25200,
      'pacific sa'            =>  -14400, 'pacific'               =>  -28800,
      'romance'               =>    3600, 'russian'               =>   10800,
      'sa eastern'            =>  -10800, 'sa pacific'            =>  -18000,
      'sa western'            =>  -14400, 'samoa'                 =>  -39600,
      'se asia'               =>   25200, 'malay peninsula'       =>   28800,
      'south africa'          =>    7200, 'sri lanka'             =>   21600,
      'taipei'                =>   28800, 'tasmania'              =>   36000,
      'tokyo'                 =>   32400, 'tonga'                 =>   46800,
      'us eastern'            =>  -18000, 'us mountain'           =>  -25200,
      'vladivostok'           =>   36000, 'w. australia'          =>   28800,
      'w. central africa'     =>    3600, 'w. europe'             =>    3600,
      'west asia'             =>   18000, 'west pacific'          =>   36000,
      'yakutsk'               =>   32400
    }.freeze

  end

  def asctime() strftime('%c') end

  alias_method :ctime, :asctime

  def iso8601() strftime('%F') end

  def rfc3339() strftime('%FT%T%:z') end

  def xmlschema() iso8601 end # :nodoc:

  def rfc2822() strftime('%a, %-d %b %Y %T %z') end

  alias_method :rfc822, :rfc2822

  def httpdate() new_offset(0).strftime('%a, %d %b %Y %T GMT') end # :nodoc:

  def jisx0301
    if jd < 2405160
      strftime('%F')
    else
      case jd
      when 2405160...2419614
        g = 'M%02d' % (year - 1867)
      when 2419614...2424875
        g = 'T%02d' % (year - 1911)
      when 2424875...2447535
        g = 'S%02d' % (year - 1925)
      else
        g = 'H%02d' % (year - 1988)
      end
      g + strftime('.%m.%d')
    end
  end

  ABBR_MONTHS_KEYS = Format::ABBR_MONTHS.keys.join('|').freeze
  private_constant :ABBR_MONTHS_KEYS

  ABBR_DAYS_KEYS = Format::ABBR_DAYS.keys.join('|').freeze
  private_constant :ABBR_DAYS_KEYS

  def self._parse_day(str, hash) # :nodoc:
    if str.sub!(/\b(#{ABBR_DAYS_KEYS})[^-\d\s]*/io, ' ')
      hash[:wday] = Format::ABBR_DAYS[$1.downcase]
      true
=begin
    elsif str.sub!(/\b(?!\dth)(su|mo|tu|we|th|fr|sa)\b/i, ' ')
      hash[:wday] = %w(su mo tu we th fr sa).index($1.downcase)
      true
=end
    end
  end

  def self._parse_time(str, hash) # :nodoc:
    if str.sub!(
                /(
                   (?:
                     \d+\s*:\s*\d+
                     (?:
                       \s*:\s*\d+(?:[,.]\d*)?
                     )?
                   |
                     \d+\s*h(?:\s*\d+m?(?:\s*\d+s?)?)?
                   )
                   (?:
                     \s*
                     [ap](?:m\b|\.m\.)
                   )?
                 |
                   \d+\s*[ap](?:m\b|\.m\.)
                 )
                 (?:
                   \s*
                   (
                     (?:gmt|utc?)?[-+]\d+(?:[,.:]\d+(?::\d+)?)?
                   |
                     [[:alpha:].\s]+(?:standard|daylight)\stime\b
                   |
                     [[:alpha:]]+(?:\sdst)?\b
                   )
                 )?
                /ix,
                ' ')

      t = $1
      hash[:zone] = $2 if $2

      match = t.match /\A(\d+)h?
              (?:\s*:?\s*(\d+)m?
                (?:
                  \s*:?\s*(\d+)(?:[,.](\d+))?s?
                )?
              )?
            (?:\s*([ap])(?:m\b|\.m\.))?/ix

      if match
        hash[:hour] = match[1].to_i
        hash[:min] = match[2]&.to_i
        hash[:sec] = match[3]&.to_i
        hash[:sec_fraction] = Rational(match[4].to_i, 10**match[4].size) if match[4]
        if match[5]
          hash[:hour] %= 12
          hash[:hour] += 12 if match[5].eql?('p') || match[5].eql?('P')
        end
      else
        hash[:hour] = 0
      end

      true
    end
  end

  def self._parse_eu(str, hash) # :nodoc:
    if str.sub!(
                /'?(\d+)[^-\d\s]*
                 \s*
                 (#{ABBR_MONTHS_KEYS})[^-\d\s']*
                 (?:
                   \s*
                   (c(?:e|\.e\.)|b(?:ce|\.c\.e\.)|a(?:d|\.d\.)|b(?:c|\.c\.))?
                   \s*
                   ('?-?\d+(?:(?:st|nd|rd|th)\b)?)
                 )?
                /iox,
                ' ') # '
      s3e(hash, $4, Format::ABBR_MONTHS[$2.downcase].to_s, $1, $3 && $3[0,1].downcase == 'b')
      true
    end
  end

  def self._parse_us(str, hash) # :nodoc:
    if str.sub!(
                /\b(#{ABBR_MONTHS_KEYS})[^-\d\s']*
                 \s*
                 ('?\d+)[^-\d\s']*
                 (?:
                   \s*
                   (c(?:e|\.e\.)|b(?:ce|\.c\.e\.)|a(?:d|\.d\.)|b(?:c|\.c\.))?
                   \s*
                   ('?-?\d+)
                 )?
                /iox,
                ' ') # '
      s3e(hash, $4, Format::ABBR_MONTHS[$1.downcase].to_s, $2, $3 && $3[0,1].downcase == 'b')
      true
    end
  end

  def self._parse_iso(str, hash) # :nodoc:
    if str.sub!(/('?[-+]?\d+)-(\d+)-('?-?\d+)/, ' ')
      s3e(hash, $1, $2, $3)
      true
    end
  end

  def self._parse_iso2(str, hash) # :nodoc:
    if str.sub!(/\b(\d{2}|\d{4})?-?w(\d{2})(?:-?(\d))?\b/i, ' ')
      hash[:cwyear] = $1.to_i if $1
      hash[:cweek] = $2.to_i
      hash[:cwday] = $3.to_i if $3
      true
    elsif str.sub!(/-w-(\d)\b/i, ' ')
      hash[:cwday] = $1.to_i
      true
    elsif str.sub!(/--(\d{2})?-(\d{2})\b/, ' ')
      hash[:mon] = $1.to_i if $1
      hash[:mday] = $2.to_i
      true
    elsif str.sub!(/--(\d{2})(\d{2})?\b/, ' ')
      hash[:mon] = $1.to_i
      hash[:mday] = $2.to_i if $2
      true
    elsif /[,.](\d{2}|\d{4})-\d{3}\b/ !~ str && str.sub!(/\b(\d{2}|\d{4})-(\d{3})\b/, ' ')
      hash[:year] = $1.to_i
      hash[:yday] = $2.to_i
      true
    elsif /\d-\d{3}\b/ !~ str && str.sub!(/\b-(\d{3})\b/, ' ')
      hash[:yday] = $1.to_i
      true
    end
  end

  def self._parse_jis(str, hash) # :nodoc:
    if str.sub!(/\b([mtsh])(\d+)\.(\d+)\.(\d+)/i, ' ')
      era = { 'm'=>1867, 't'=>1911, 's'=>1925, 'h'=>1988 }[$1.downcase]
      hash[:year] = $2.to_i + era
      hash[:mon] = $3.to_i
      hash[:mday] = $4.to_i
      true
    end
  end

  def self._parse_vms(str, hash) # :nodoc:
    if str.sub!(/('?-?\d+)-(#{ABBR_MONTHS_KEYS})[^-\/.]*-('?-?\d+)/iox, ' ')
      s3e(hash, $3, Format::ABBR_MONTHS[$2.downcase].to_s, $1)
      true
    elsif str.sub!(/\b(#{ABBR_MONTHS_KEYS})[^-\/.]*-('?-?\d+)(?:-('?-?\d+))?/iox, ' ')
      s3e(hash, $3, Format::ABBR_MONTHS[$1.downcase].to_s, $2)
      true
    end
  end

  def self._parse_sla(str, hash) # :nodoc:
    if str.sub!(%r|('?-?\d+)/\s*('?\d+)(?:\D\s*('?-?\d+))?|, ' ') # '
      s3e(hash, $1, $2, $3)
      true
    end
  end

  def self._parse_dot(str, hash) # :nodoc:
    if str.sub!(%r|('?-?\d+)\.\s*('?\d+)\.\s*('?-?\d+)|, ' ') # '
      s3e(hash, $1, $2, $3)
      true
    end
  end

  def self._parse_year(str, hash) # :nodoc:
    if str.sub!(/'(\d+)\b/, ' ')
      hash[:year] = $1.to_i
      true
    end
  end

  def self._parse_mon(str, hash) # :nodoc:
    if str.sub!(/\b(#{ABBR_MONTHS_KEYS})\S*/io, ' ')
      hash[:mon] = Format::ABBR_MONTHS[$1.downcase]
      true
    end
  end

  def self._parse_mday(str, hash) # :nodoc:
    if str.sub!(/(\d+)(st|nd|rd|th)\b/i, ' ')
      hash[:mday] = $1.to_i
      true
    end
  end

  def self._parse_ddd(str, hash) # :nodoc:
    if str.sub!(
                /([-+]?)(\d{2,14})
                  (?:
                    \s*
                    t?
                    \s*
                    (\d{2,6})?(?:[,.](\d*))?
                  )?
                  (?:
                    \s*
                    (
                      z\b
                    |
                      [-+]\d{1,4}\b
                    |
                      \[[-+]?\d[^\]]*\]
                    )
                  )?
                /ix,
                ' ')
      case $2.size
      when 2
        if $3.nil? && $4
          hash[:sec]  = $2[-2, 2].to_i
        else
          hash[:mday] = $2[ 0, 2].to_i
        end
      when 4
        if $3.nil? && $4
          hash[:sec]  = $2[-2, 2].to_i
          hash[:min]  = $2[-4, 2].to_i
        else
          hash[:mon]  = $2[ 0, 2].to_i
          hash[:mday] = $2[ 2, 2].to_i
        end
      when 6
        if $3.nil? && $4
          hash[:sec]  = $2[-2, 2].to_i
          hash[:min]  = $2[-4, 2].to_i
          hash[:hour] = $2[-6, 2].to_i
        else
          hash[:year] = ($1 + $2[ 0, 2]).to_i
          hash[:mon]  = $2[ 2, 2].to_i
          hash[:mday] = $2[ 4, 2].to_i
        end
      when 8, 10, 12, 14
        if $3.nil? && $4
          hash[:sec]  = $2[-2, 2].to_i
          hash[:min]  = $2[-4, 2].to_i
          hash[:hour] = $2[-6, 2].to_i
          hash[:mday] = $2[-8, 2].to_i
          if $2.size >= 10
            hash[:mon] = $2[-10, 2].to_i
          end
          if $2.size == 12
            hash[:year] = ($1 + $2[-12, 2]).to_i
          end
          if $2.size == 14
            hash[:year] = ($1 + $2[-14, 4]).to_i
            hash[:_comp] = false
          end
        else
          hash[:year] = ($1 + $2[ 0, 4]).to_i
          hash[:mon]  = $2[ 4, 2].to_i
          hash[:mday] = $2[ 6, 2].to_i
          hash[:hour] = $2[ 8, 2].to_i if $2.size >= 10
          hash[:min]  = $2[10, 2].to_i if $2.size >= 12
          hash[:sec]  = $2[12, 2].to_i if $2.size >= 14
          hash[:_comp] = false
        end
      when 3
        if $3.nil? && $4
          hash[:sec]  = $2[-2, 2].to_i
          hash[:min]  = $2[-3, 1].to_i
        else
          hash[:yday] = $2[ 0, 3].to_i
        end
      when 5
        if $3.nil? && $4
          hash[:sec]  = $2[-2, 2].to_i
          hash[:min]  = $2[-4, 2].to_i
          hash[:hour] = $2[-5, 1].to_i
        else
          hash[:year] = ($1 + $2[ 0, 2]).to_i
          hash[:yday] = $2[ 2, 3].to_i
        end
      when 7
        if $3.nil? && $4
          hash[:sec]  = $2[-2, 2].to_i
          hash[:min]  = $2[-4, 2].to_i
          hash[:hour] = $2[-6, 2].to_i
          hash[:mday] = $2[-7, 1].to_i
        else
          hash[:year] = ($1 + $2[ 0, 4]).to_i
          hash[:yday] = $2[ 4, 3].to_i
        end
      end
      if $3
        if $4
          case $3.size
          when 2, 4, 6
            hash[:sec]  = $3[-2, 2].to_i
            hash[:min]  = $3[-4, 2].to_i if $3.size >= 4
            hash[:hour] = $3[-6, 2].to_i if $3.size >= 6
          end
        else
          case $3.size
          when 2, 4, 6
            hash[:hour] = $3[ 0, 2].to_i
            hash[:min]  = $3[ 2, 2].to_i if $3.size >= 4
            hash[:sec]  = $3[ 4, 2].to_i if $3.size >= 6
          end
        end
      end
      if $4
        hash[:sec_fraction] = Rational($4.to_i, 10**$4.size)
      end
      if $5
        hash[:zone] = zone = $5
        if zone[0] == '['
          o, n, = zone[1..-2].split(':')
          hash[:zone] = n || o
          if /\A\d/ =~ o
            o = format('+%s', o)
          end
          hash[:offset] = zone_to_diff(o)
        end
      end
      true
    end
  end

  private_class_method :_parse_day, :_parse_time,
        :_parse_eu, :_parse_us, :_parse_iso, :_parse_iso2,
        :_parse_jis, :_parse_vms, :_parse_sla, :_parse_dot,
        :_parse_year, :_parse_mon, :_parse_mday, :_parse_ddd

  def self._parse(str, comp=true)
    # Newer MRI version (written in C converts non-strings to strings
    # and also has other checks like all ascii.
    if str.kind_of?(::String)
      # no-op
    elsif str.respond_to?(:to_str)
      str = str.to_str
    else
      raise TypeError, "no implicit conversion of #{str.class.name} into String"
    end
    # we do not str = str.dup since we do a gsub (instead of gsub!)

    str = str.gsub(/[^-+',.\/:@[:alnum:]\[\]]+/, ' ')

    hash = { :_comp => comp }

    _parse_time(str, hash) # || _parse_beat(str, hash)
    _parse_day(str, hash)

    _parse_eu(str, hash)     ||
    _parse_us(str, hash)     ||
    _parse_iso(str, hash)    ||
    _parse_jis(str, hash)    ||
    _parse_vms(str, hash)    ||
    _parse_sla(str, hash)    ||
    _parse_dot(str, hash)    ||
    _parse_iso2(str, hash)   ||
    _parse_year(str, hash)   ||
    _parse_mon(str, hash)    ||
    _parse_mday(str, hash)   ||
    _parse_ddd(str, hash)

    if str.sub!(/\b(bc\b|bce\b|b\.c\.|b\.c\.e\.)/i, ' ')
      if year = hash[:year]
        hash[:year] = -year + 1
      end
    end

    if str.sub!(/\A\s*(\d{1,2})\s*\z/, ' ')
      if hash[:hour] && !hash[:mday]
        v = $1.to_i
        if 1 <= v && v <= 31
          hash[:mday] = v
        end
      end
      if hash[:mday] && !hash[:hour]
        v = $1.to_i
        if 0 <= v && v <= 24
          hash[:hour] = v
        end
      end
    end

    if hash[:_comp]
      if cwyear = hash[:cwyear]
        if cwyear >= 0 && cwyear <= 99
          hash[:cwyear] += cwyear >= 69 ? 1900 : 2000
        end
      end
      if year = hash[:year]
        if year >= 0 && year <= 99
          hash[:year] += year >= 69 ? 1900 : 2000
        end
      end
    end

    hash[:offset] ||= zone_to_diff(hash[:zone]) if hash[:zone]

    hash.reject! { |k, v| v.nil? || k[0].eql?('_') }
    hash
  end

  def self._iso8601(str) # :nodoc:
    h = {}
    if /\A\s*
      (?:
          (?<year>[-+]?\d{2,} | -) - (?<mon>\d{2})? - (?<mday>\d{2})
        | (?<year>[-+]?\d{2,})? - (?<yday>\d{3})
        | (?<cwyear>\d{4}|\d{2})? - w(?<cweek>\d{2}) - (?<cwday>\d)
        | -w- (?<cwday2>\d)
      )
      (?:
        t
        (?<hour>\d{2}) : (?<min>\d{2}) (?: :(?<sec>\d{2})(?:[,.](?<sec_fraction>\d+))?)?
        (?<zone>z | [-+]\d{2}(?::?\d{2})?)?
      )?
      \s*\z/ix =~ str

      if mday
        h[:mday] = i mday
        h[:year] = comp_year69(year) if year != "-"

        if mon
          h[:mon] = i mon
        else
          return {} if year != "-"
        end
      elsif yday
        h[:yday] = i yday
        h[:year] = comp_year69(year) if year
      elsif cwday
        h[:cweek] = i cweek
        h[:cwday] = i cwday
        h[:cwyear] = comp_year69(cwyear) if cwyear
      elsif cwday2
        h[:cwday] = i cwday2
      end

      if hour
        h[:hour] = i hour
        h[:min] = i min
        h[:sec] = i sec if sec
      end

      h[:sec_fraction] = Rational(sec_fraction.to_i, 10**sec_fraction.size) if sec_fraction # JRuby bug fix!
      set_zone(h, zone) if zone

    elsif /\A\s*
      (?:
          (?<year>[-+]?(?:\d{4}|\d{2})|--) (?<mon>\d{2}|-) (?<mday>\d{2})
        | (?<year>[-+]?(?:\d{4}|\d{2})) (?<yday>\d{3})
        | -(?<yday2>\d{3})
        | (?<cwyear>\d{4}|\d{2}|-) w(?<cweek>\d{2}|-) (?<cwday>\d)
      )
      (?:
        t?
        (?<hour>\d{2}) (?<min>\d{2}) (?:(?<sec>\d{2})(?:[,.](?<sec_fraction>\d+))?)?
        (?<zone>z | [-+]\d{2}(?:\d{2})?)?
      )?
      \s*\z/ix =~ str

      if mday
        h[:mday] = i mday
        h[:year] = comp_year69(year) if year != "--"
        if mon != "-"
          h[:mon] = i mon
        else
          return {} if year != "--"
        end
      elsif yday
        h[:yday] = i yday
        h[:year] = comp_year69(year)
      elsif yday2
        h[:yday] = i yday2
      elsif cwday
        h[:cweek] = i cweek if cweek != "-"
        h[:cwday] = i cwday
        h[:cwyear] = comp_year69(cwyear) if cwyear != "-"
      end

      if hour
        h[:hour] = i hour
        h[:min] = i min
        h[:sec] = i sec if sec
      end

      h[:sec_fraction] = Rational(sec_fraction.to_i, 10**sec_fraction.size) if sec_fraction # JRuby bug fix!
      set_zone(h, zone) if zone

    elsif /\A\s*
      (?<hour>\d{2})
      (?:
        : (?<min>\d{2})
        (?:
          :(?<sec>\d{2})(?:[,.](?<sec_fraction>\d+))?
          (?<zone>z | [-+]\d{2}(?: :?\d{2})?)?
        )?
      |
        (?<min>\d{2})
        (?:
          (?<sec>\d{2})(?:[,.](?<sec_fraction>\d+))?
          (?<zone>z | [-+]\d{2}(?:\d{2})?)?
        )?
      )
      \s*\z/ix =~ str

      h[:hour] = i hour
      h[:min] = i min
      h[:sec] = i sec if sec
      h[:sec_fraction] = Rational(sec_fraction.to_i, 10**sec_fraction.size) if sec_fraction # JRuby bug fix!
      set_zone(h, zone) if zone
    end
    h
  end

  def self._rfc3339(str) # :nodoc:
    if /\A\s*-?\d{4}-\d{2}-\d{2} # allow minus, anyway
        (t|\s)
        \d{2}:\d{2}:\d{2}(\.\d+)?
        (z|[-+]\d{2}:\d{2})\s*\z/ix =~ str
      _parse(str)
    else
      {}
    end
  end

  def self._xmlschema(str) # :nodoc:
    if /\A\s*(-?\d{4,})(?:-(\d{2})(?:-(\d{2}))?)?
        (?:t
          (\d{2}):(\d{2}):(\d{2})(?:\.(\d+))?)?
        (z|[-+]\d{2}:\d{2})?\s*\z/ix =~ str
      hash = Hash.new
      hash[:year] = $1.to_i
      hash[:mon] = $2.to_i if $2
      hash[:mday] = $3.to_i if $3
      hash[:hour] = $4.to_i if $4
      hash[:min] = $5.to_i if $5
      hash[:sec] = $6.to_i if $6
      hash[:sec_fraction] = Rational($7.to_i, 10**$7.size) if $7
      if $8
        hash[:zone] = $8
        hash[:offset] = zone_to_diff($8)
      end
      hash
    elsif /\A\s*(\d{2}):(\d{2}):(\d{2})(?:\.(\d+))?
        (z|[-+]\d{2}:\d{2})?\s*\z/ix =~ str
      hash = Hash.new
      hash[:hour] = $1.to_i if $1
      hash[:min] = $2.to_i if $2
      hash[:sec] = $3.to_i if $3
      hash[:sec_fraction] = Rational($4.to_i, 10**$4.size) if $4
      if $5
        hash[:zone] = $5
        hash[:offset] = zone_to_diff($5)
      end
      hash
    elsif /\A\s*(?:--(\d{2})(?:-(\d{2}))?|---(\d{2}))
        (z|[-+]\d{2}:\d{2})?\s*\z/ix =~ str
      hash = Hash.new
      hash[:mon] = $1.to_i if $1
      hash[:mday] = $2.to_i if $2
      hash[:mday] = $3.to_i if $3
      if $4
        hash[:zone] = $4
        hash[:offset] = zone_to_diff($4)
      end
      hash
    else
      {}
    end
  end

  def self._rfc2822(str) # :nodoc:
    if /\A\s*(?:(?:#{Format::ABBR_DAYS.keys.join('|')})\s*,\s+)?
        \d{1,2}\s+
        (?:#{Format::ABBR_MONTHS.keys.join('|')})\s+
        -?(\d{2,})\s+ # allow minus, anyway
        \d{2}:\d{2}(:\d{2})?\s*
        (?:[-+]\d{4}|ut|gmt|e[sd]t|c[sd]t|m[sd]t|p[sd]t|[a-ik-z])\s*\z/iox =~ str
      hash = _parse(str, false)
      if $1.size < 4
        if hash[:year] < 50
          hash[:year] += 2000
        elsif hash[:year] < 1000
          hash[:year] += 1900
        end
      end
      hash
    else
      {}
    end
  end

  class << self; alias_method :_rfc822, :_rfc2822 end

  def self._httpdate(str) # :nodoc:
    if /\A\s*(#{Format::ABBR_DAYS.keys.join('|')})\s*,\s+
        \d{2}\s+
        (#{Format::ABBR_MONTHS.keys.join('|')})\s+
        -?\d{4}\s+ # allow minus, anyway
        \d{2}:\d{2}:\d{2}\s+
        gmt\s*\z/iox =~ str
      _rfc2822(str)
    elsif /\A\s*(#{Format::DAYS.keys.join('|')})\s*,\s+
        \d{2}\s*-\s*
        (#{Format::ABBR_MONTHS.keys.join('|')})\s*-\s*
        \d{2}\s+
        \d{2}:\d{2}:\d{2}\s+
        gmt\s*\z/iox =~ str
      _parse(str)
    elsif /\A\s*(#{Format::ABBR_DAYS.keys.join('|')})\s+
        (#{Format::ABBR_MONTHS.keys.join('|')})\s+
        \d{1,2}\s+
        \d{2}:\d{2}:\d{2}\s+
        \d{4}\s*\z/iox =~ str
      _parse(str)
    else
      {}
    end
  end

  def self._jisx0301(str) # :nodoc:
    if /\A\s*[mtsh]?\d{2}\.\d{2}\.\d{2}
        (t
        (\d{2}:\d{2}(:\d{2}([,.]\d*)?)?
        (z|[-+]\d{2}(:?\d{2})?)?)?)?\s*\z/ix =~ str
      if /\A\s*\d/ =~ str
        _parse(str.sub(/\A\s*(\d)/, 'h\1'))
      else
        _parse(str)
      end
    else
      _iso8601(str)
    end
  end

  def self.set_zone(hash, zone) # :nodoc:
    hash[:zone] = zone
    hash[:offset] = zone_to_diff(zone)
  end
  private_class_method :set_zone

end

class DateTime < Date

  def iso8601_timediv(n) # :nodoc:
    n = n.to_i
    strftime('T%T' +
             if n < 1
               ''
             else
               '.%0*d' % [n, (sec_fraction * 10**n).round]
             end +
             '%:z')
  end
  private :iso8601_timediv

  def iso8601(n=0)
    super() + iso8601_timediv(n)
  end

  def rfc3339(n=0) iso8601(n) end

  def xmlschema(n=0) iso8601(n) end # :nodoc:

  def jisx0301(n=0)
    super() + iso8601_timediv(n)
  end

end
