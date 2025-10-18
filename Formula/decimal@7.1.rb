# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT71 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://github.com/php-decimal/ext-decimal/archive/v1.5.0.tar.gz"
  sha256 "f00455a058aa22a9c9e7e5c409ee75980068bc9b8f03b17fad39d2bca2138d5d"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e24130029b86d60489a939f5ace8effd326a4e3feb65015fc8ac306d907a4974"
    sha256 cellar: :any,                 arm64_sonoma:  "626a683d6286c9f65f5e2c21ef5181a8f56a544e9d4a258791909988b0944c4e"
    sha256 cellar: :any,                 arm64_ventura: "afe000afce1f99091fe63ed444bd649ac5f98c5d2550fec2924c958e08b269a6"
    sha256 cellar: :any,                 ventura:       "4db2a0ca19933c11c1e5b4b14222b139f3448ada5abf481634c7a0c4165a2832"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "19cce4fd34fc2982fbdeedad54e69c05e957e8b66b20f5cf27c867ca230928fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d48e0271e8fb1606f7e0b63a7440b4c5027097673cff58277c776f973512c5ba"
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
