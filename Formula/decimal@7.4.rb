# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT74 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-1.5.3.tgz"
  sha256 "168bdcc445e1557b889df5e46313825f2abc77c5d7cfb7a4215063d2f7ca4a97"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(1\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "16b13618c87a6f67fe083e42c067f75fff160f342408301188263c9558b406b0"
    sha256 cellar: :any,                 arm64_sequoia: "cbeafd9fff06f8a950ecbf11cd2b24204b619e9c4af5ab5efa94073677477248"
    sha256 cellar: :any,                 arm64_sonoma:  "3ec53e6f9bb3a7ea4e127a4bc8015a52b141bec6ec4728f017d88ccf2f0b522c"
    sha256 cellar: :any,                 sonoma:        "e2792ce07897dd46dda9054e335d5233ed742680b7e62374fda6288d748b617b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cb4859c9e1f32cf89c8a4843c784366202d13efe5bbb4321bf5627d454b2e33a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da4eb92906903119a2b28cc61af23cb3dfd45b02017f778c512fca952dd60005"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
    ]
    Dir.chdir "decimal-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
