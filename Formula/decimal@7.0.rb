# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "33ffc88d5142ab69a7471b978745cc5e2e0fca83ac6ae22dfd41d56466e0a458"
    sha256 cellar: :any,                 arm64_sonoma:  "f25c1fef890463b9a86d96c59a44e7d820137fbb96f9767592c504e3e4ab4093"
    sha256 cellar: :any,                 arm64_ventura: "e32312b64003c945ea705c878916d0f90a1b82564f1827498d77aa4add08af76"
    sha256 cellar: :any,                 sonoma:        "87d7c22802714e158e58f9f54fc98489cc278e25a37724e7dc6dbb5a004ca429"
    sha256 cellar: :any,                 ventura:       "2cea59ea5030b7fb5f663a4209ab7cf092ebb2f1ab5410d2192522149e844e19"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "79f5f2776e1dc8862a103cc8220b87590f93108ae903068c841e87c7020c013c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad7608132470cd59dd20aeba1573ec752fd6e3718a7dfe7024f5bc8023470429"
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
