# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT74 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "3192cfda2af189f954f5666c1348e1c7d276a2c89036cfa8c901002db5957c00"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "5c3907427f35362de819e2dba14e0d37acf76257db467ee3e7377f553594f2b9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3c4d16a00c2a6015b9df61459d1d50d3b2563392b4bb19ed021567d750bd12cd"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f0caeb7d80946350ee9ce2fa7edcedf63fe35ae5980c5420d2874071596c54b3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "99e4b25371a9eaef8073cfa0dcd4025d5a6a6f859595618d19fc90045ffb31b4"
    sha256 cellar: :any_skip_relocation, ventura:        "6925d76888a5d53f12f54681f4967346145e6170449a59a732a7e0315414b07d"
    sha256 cellar: :any_skip_relocation, monterey:       "b3cbbcc02a63f753ecb8bbf38d6e67a44fd9050187548afc70fb10b2c18fbc3a"
    sha256 cellar: :any_skip_relocation, big_sur:        "26079e4c1a075b534ef071b0421a68cb9cd376499ce1d75b0b6c939cb9762910"
    sha256 cellar: :any_skip_relocation, catalina:       "730e0a5f529466c901df379781f0f864e2b05afce2aba2b288ccecdfd4b7243a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cdaf337bae088a7cf1066a0e5010065a81f3a2209e6eb436be6d3ea9a0059bbb"
  end

  depends_on "pcre"

  def install
    Dir.chdir "psr-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-psr"
    system "make"
    prefix.install "modules/psr.so"
    write_config_file
  end
end
