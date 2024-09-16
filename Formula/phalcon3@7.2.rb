# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon3AT72 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v3.4.5.tar.gz"
  sha256 "4c56420641a4a12f95e93e65a107aba8ef793817da57a4c29346c012faf66777"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "0b14526685a8ab482f55db8fd9eeb3ebd08862c229f19727001a4bea03c571a8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "77bc2fb6a13d3cb531a7f85766f31bfb55a62bef1ea90bb6c7fe984dc9d74a11"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a8f03f997fc45e117bb965bd6225c96579b556cb9411e18f97123bc9e2fc2123"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1149f13c6d62c0941f3db1ebc3540552b00104693769f519a602b8ea38c9eb63"
    sha256 cellar: :any_skip_relocation, ventura:        "cdb56df05160b38447e7c1f7cd1d506e6ee35ce3f6b1ae21ab78b6c61ae0e431"
    sha256 cellar: :any_skip_relocation, big_sur:        "bc2f825f2b80dd1d38f699ac28c6823dfac969fc5232331034ca6ef4a17ab865"
    sha256 cellar: :any_skip_relocation, catalina:       "339cc064cfae0dd808f3c3560610894103fc86ccb925ce475796acde80d3e3bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e225445886914f3c9d4b7ae3927382f0299fcce2bfb0030737b8d355aa86cbae"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.2"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
