# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon3AT56 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v3.4.5.tar.gz"
  sha256 "4c56420641a4a12f95e93e65a107aba8ef793817da57a4c29346c012faf66777"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "f43a1dcb680a3ba41ba9586bbba2c32eb23d3c3ee9bd63724feb37470b3a8d93"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d3bac87d5d9bf3ed056328db142650c003b52a550c6c3e0183e9446909f4d0c8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "87b765a6df7cd98736e6374d123e19c255e9b954b6458e53b6ce81f132cb5844"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2994a241d54910c57632c23c4f9692399db9e9856205743ec50d22b044231f28"
    sha256 cellar: :any_skip_relocation, ventura:        "8bf8cc4a9e9a4dbd988551bfbae559be1684a0386c3f58c892e95488ea45c149"
    sha256 cellar: :any_skip_relocation, big_sur:        "7baabf661cd9d619a32a4a3ffc6935220d54fcba56d6cb289589440a2816c1cc"
    sha256 cellar: :any_skip_relocation, catalina:       "27609b942a6e61bac3369616ddf18375623b60eb4ed81403385ca2cc91671499"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "993002163f41198a9d9c0ad2b96d4f9c5393f94f8dd47a94a72fb86fa4125f4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7702738234084ab284d62e31bb2b39284fb91a4ce2b0ad2da8040154a38b85c"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@5.6"

  def install
    Dir.chdir "build/php5/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
