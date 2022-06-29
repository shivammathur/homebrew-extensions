# typed: false
# frozen_string_literal: true

# Abstract class for PHP extensions
class AbstractPhpExtension < Formula
  desc "Abstract class for PHP Extension Formula"
  homepage "https://github.com/shivammathur/homebrew-extensions"

  def initialize(*)
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
    config_scandir_path / "#{extension}.ini"
  end

  def priority_config_filepath
    config_scandir_path / "#{priority}-#{extension}.ini"
  end

  def safe_phpize
    ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
    ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    system "#{Formula[php_formula].opt_bin}/phpize"
  end

  def write_config_file
    config_file = config_filepath
    priority_config_file = priority_config_filepath
    mv config_file, priority_config_file if config_file.exist?
    config_scandir_path.mkpath
    priority_config_file.write(config_file_content)
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

  def add_expect_lib
    expect_lib = Dir["#{Formula["expect"].opt_lib}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  class << self
    attr_reader :php_version, :extension

    attr_rw :priority

    def init
      class_name = name.split("::").last
      matches = /(\w+)AT(\d)(\d)/.match(class_name)
      @extension = matches[1].downcase if matches
      @extension = (@extension != "ssh2") ? matches[1].downcase.tr("0-9", "").gsub("pecl", "") : "ssh2"
      @php_version = "#{matches[2]}.#{matches[3]}" if matches
      depends_on "autoconf" => :build
      depends_on "pkg-config" => :build
      depends_on "shivammathur/php/php@#{@php_version}" => [:build, :test]
    end
  end
end
