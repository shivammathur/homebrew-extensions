# typed: false
# frozen_string_literal: true

# Abstract class for PHP extensions
class AbstractPhpExtension < Formula
  desc "Abstract class for PHP Extension Formula"
  homepage "https://github.com/shivammathur/homebrew-extensions"

  NAME_REGEX = /\w+AT(\d)(\d)/.freeze

  def self.init
    class_name = name.split("::").last
    matches = NAME_REGEX.match(class_name)
    depends_on "autoconf" => :build
    depends_on "pkg-config" => :build
    depends_on "shivammathur/php/php@#{matches[1]}.#{matches[2]}" => [:build, :test]
  end

  def php_version
    class_name = self.class.name.split("::").last
    matches = NAME_REGEX.match(class_name)
    "#{matches[1]}.#{matches[2]}" if matches
  end

  def php_formula
    "php@#{php_version}"
  end

  def safe_phpize
    ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
    ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    system "#{Formula[php_formula].opt_bin}/phpize"
  end

  def phpconfig
    "--with-php-config=#{Formula[php_formula].opt_bin}/php-config"
  end

  def extension
    class_name = self.class.name.split("::").last.split("AT").first
    raise "Unable to guess PHP extension name for #{class_name}" unless class_name

    class_name.downcase.tr("0-9", "").gsub("pecl", "")
  end

  def extension_type
    if extension == "xdebug"
      "zend_extension"
    else
      "extension"
    end
  end

  def module_path
    opt_prefix / "#{extension}.so"
  end

  def config_file
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
    EOS
  rescue error
    raise error
  end

  def caveats
    <<~EOS
      To finish installing #{extension} for PHP #{php_version}:
        * #{config_filepath} was created,"
          do not forget to remove it upon extension removal."
        * Validate installation by running php -m
    EOS
  end

  test do
    output = shell_output("#{Formula[php_formula].opt_bin}/php -m").downcase
    assert_match(/#{extension.downcase}/, output, "failed to find extension in php -m output")
  end

  def config_scandir_path
    etc / "php" / php_version / "conf.d"
  end

  def config_filepath
    config_scandir_path / "#{extension}.ini"
  end

  def write_config_file
    if config_filepath.file?
      inreplace config_filepath do |s|
        s.gsub!(/^(;)?(\s*)(zend_)?extension=.+$/, "\\1\\2#{extension_type}=\"#{module_path}\"")
      end
    elsif config_file
      config_scandir_path.mkpath
      config_filepath.write(config_file)
    end
  end

  def add_include_files
    files = Dir["*.h"]
    (include/"php/ext/#{extension}@#{php_version}").install files unless files.empty?
  end

  def patch_spl_symbols
    %w[Aggregate ArrayAccess Countable Iterator Serializable Stringable Traversable].each do |s|
      files = Dir["**/*"].select { |f| File.file?(f) && File.read(f).scrub.include?("spl_ce_#{s}") }
      inreplace files, "spl_ce_#{s}", "zend_ce_#{s}".downcase unless files.empty?
    end
  end
end
