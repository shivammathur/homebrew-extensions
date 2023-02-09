# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.13.tar.gz"
  sha256 "4400ecefafe0901c2ead0e1770b0d4041151e0c51bcb27c4a6c30becb1acb7da"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fdf068a3d65817f73bd3ae7a271f54170b5c003e82a3370692ad450f65d666a4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "072b00e3ec83ae9fee1a270b912d1c7016c7acdab16a29aff4d3bcce44faf332"
    sha256 cellar: :any_skip_relocation, monterey:       "1199e9631a4cafd297ec0b51abb4e5cfedac12939b0d93be58c388399b0e25b9"
    sha256 cellar: :any_skip_relocation, big_sur:        "61f5263f2f37d1d65f4bd6fdadd035c6c89574f03ea485f49fd218f1810be1ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "66c6fbe9cd6fa95974ceb39c14d1cceb7f16f3c5ab61b8f4892d0c33f8cb286c"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
