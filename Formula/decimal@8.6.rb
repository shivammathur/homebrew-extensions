# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT86 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://github.com/php-decimal/ext-decimal/archive/v1.5.0.tar.gz"
  sha256 "f00455a058aa22a9c9e7e5c409ee75980068bc9b8f03b17fad39d2bca2138d5d"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "050bac096d6422d93983b831a2c04b2d87a2c5b800c476b4f6549de321a505ea"
    sha256 cellar: :any,                 arm64_sequoia: "32a6a494fd94d802b1e6f361a2ce9625a9590ecf7065fed030053de5ea3d2432"
    sha256 cellar: :any,                 arm64_sonoma:  "e1a6ef39ffeed3e64d8dadacecb1f7259064eb088d8cc1ce10fe65de75655426"
    sha256 cellar: :any,                 sonoma:        "c95546324294e226324a3be63286d364c3c3f9facac065f841c96fed08c1f9f3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "00b2af6eb5a20e8e6478bf1898d7bd3a6be16c637f8dd0d77535049b3360e205"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c1d2fb577910c36e4521b3ef72830e63d83aa042ee085a4d3ecfeeec2016d31"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
    ]
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
