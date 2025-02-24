# typed: true
# frozen_string_literal: true

# Abstract class for PHP extensions
class AbstractPhpExtension < Formula
  desc "Abstract class for PHP Extension Formula"
  homepage "https://github.com/shivammathur/homebrew-extensions"

  def initialize(name, path, spec, alias_path: nil, tap: nil, force_bottle: false)
    super
    @priority = self.class.priority || "20"
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

  private

  attr_reader :priority

  delegate [:php_version, :extension] => :"self.class"

  def php_formula
    "shivammathur/php/php@#{php_version}"
  end

  def phpconfig
    "--with-php-config=#{Formula[php_formula].opt_bin}/php-config"
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

  def config_file_content
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
    EOS
  rescue error
    raise error
  end

  def config_scandir_path
    etc / "php" / php_version / "conf.d"
  end

  def config_filepath
    config_scandir_path / "#{priority}-#{extension}.ini"
  end

  def safe_phpize
    ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
    ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    system "#{Formula[php_formula].opt_bin}/phpize"
  end

  def write_config_file
    Dir[config_scandir_path / "*#{extension}*.ini"].each do |ini_file|
      rm ini_file
    end
    config_scandir_path.mkpath
    config_filepath.write(config_file_content)
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

  class << self
    attr_reader :php_version, :extension

    sig { params(val: T::Boolean).returns(T.nilable(T::Boolean)) }
    def priority(val = T.unsafe(nil))
      val.nil? ? @priority : @priority = val
    end

    def parse_extension(matches)
      @extension = matches[1].downcase if matches
      @extension.gsub("pecl", "").gsub("pdo", "pdo_").gsub("xdebug2", "xdebug").gsub(/phalcon\d+/, "phalcon")
    end

    def init
      class_name = name.split("::").last
      matches = /(\w+)AT(\d)(\d)/.match(class_name)
      @extension = parse_extension matches
      @php_version = "#{matches[2]}.#{matches[3]}" if matches
      depends_on "autoconf" => :build
      depends_on "pkgconf" => :build
      depends_on "shivammathur/php/php@#{@php_version}" => [:build, :test]
    end
  end
end
