# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT86 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  revision 3
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "9b06049c3bce98677e4bf93169f611487b7d7956f5fb7082a4b0c8c5b5430309"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "e8ef08c019b638ca32a43b8153e5c34bf264de87162ec246b692de4fa74be494"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "46e5ce7746f4e2166e4c65d330fb97d8d5b70c81e9ccf4b186fc00496133f704"
    sha256 cellar: :any,                 arm64_linux:       "3e4442fbbe3f7c57797b8e8eadbcbdca421f34879dc312ccb6eff6a82b3b0313"
    sha256 cellar: :any,                 x86_64_linux:      "c203b534570998b187d69fce12a12edaf1d13fd633e3b41d325adc73cd22011c"
  end

  def install
    Dir.chdir "apcu-#{version}"
    inreplace "apc.c", 'php_verror(NULL, "", verbosity, format, args);',
                       "php_verror(NULL, verbosity, format, args);"
    inreplace "apc_persist.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE();"
    if File.read("apc_cache.c").include?("zval_dtor")
      inreplace("apc_cache.c") { |s| s.gsub! "zval_dtor", "zval_ptr_dtor_nogc" }
    end
    inreplace %w[apc_cache.h apc_iterator.c apc_iterator.h], "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
