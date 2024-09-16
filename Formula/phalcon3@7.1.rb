# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon3AT71 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v3.4.5.tar.gz"
  sha256 "4c56420641a4a12f95e93e65a107aba8ef793817da57a4c29346c012faf66777"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "127acfe534b45eca6eb8912c5aef4c35fb7b87ff85873f9351a3ac2cc91d5d11"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ba702baae6aad7e7885e646a91c3ac4a1f4c019b1c3db40b216ba895ecbb09bb"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ccb4c43b2a5ddff5991b0f7e28db82c30e7c9077c3795bbb973286a51cbf8883"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0598a203279e0f07695d3e1c7648bf16e797ded88aaad1d49104483d4596c63a"
    sha256 cellar: :any_skip_relocation, ventura:        "a8429780e32fceded97d3da7003d5061556faec688e96ad64512e57619f2e6f3"
    sha256 cellar: :any_skip_relocation, big_sur:        "7b45f98d2144ef08f4649fc8ae181787c1bbfc7a7cb0519f07f4a3e6d8401d6b"
    sha256 cellar: :any_skip_relocation, catalina:       "95ba6a141cee048cad040562a79b2b41b08a393f2d525884639dbf9c4bd03c60"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e036b6371cdd8699dd2055965861f91d62557664609efa8c0d92ef69dbfef97b"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.1"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
