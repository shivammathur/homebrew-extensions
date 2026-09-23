# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT87 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.5.0.tgz"
  sha256 "a943427fae39a5503c813179018ae6c500323c8c9fb434e1a9a665fb32a4d7b4"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "18686b083370b76fa25bb0a27c50f4dd971122c047c9e5fa665a4bc57aa5bd11"
    sha256 cellar: :any, arm64_tahoe:       "e7786ab9735352221693e3ab726d56cf53ac6fe756972d8a775c844d397a2f5e"
    sha256 cellar: :any, arm64_sequoia:     "78b8e60f7823e6dd5edcbd2c9e72937188c8e25b46936bdee44d1243f7656295"
    sha256 cellar: :any, arm64_linux:       "e899e76597b1cf3cc45a7dc865c556f2a71075920e11f7f4d9acf9c4adcee541"
    sha256 cellar: :any, x86_64_linux:      "5564393b48dada9522cac7bb90853793b481491998d0cd137c9aec4c686aea85"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "zval_is_true(&zretval)", "zend_is_true(&zretval)"
    inreplace "ssh2_fopen_wrappers.c", "zval_dtor(&copyval);", "zval_ptr_dtor(&copyval);"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
