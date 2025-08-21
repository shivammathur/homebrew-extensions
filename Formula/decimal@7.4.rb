# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "e5f497b28b87868d8eeb712773b5be0b4c6850b1017f7ce00b97aaae95bf615b"
    sha256 cellar: :any,                 arm64_sonoma:  "d47601d8a4198330fd3a9e95d6bc146343034e43014188c8cfe2ef44326a4c6e"
    sha256 cellar: :any,                 arm64_ventura: "9631cdb428e54180397ebb54963e0204d6c841013ed81269ebb5d29f86613dd0"
    sha256 cellar: :any,                 ventura:       "2a1941bd6b8771d51146060890a27f74ee6fdb14faaace4f032688d85d5ecbc7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0c6f3df69c3eb0a1cc58789f9eee69887f77a2a02c9d4201ed40b2828e0c909b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ac7888eda8e430b380f123fa64cb8b050eb430ac59f927e0bc850f23c54f9cb"
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
