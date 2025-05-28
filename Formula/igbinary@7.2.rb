# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    strategy :git do |tags|
      semver_tags = tags.map(&:to_s).grep(/^v?\d+(\.\d+)+$/)
      semver_tags.max_by { |tag| Version.new(tag.delete_prefix("v")) }
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "3069d23f3f026ecd40acab401a008520d5aec55e8b74195d5da2d9af2767780c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a3a19c25e11d5b780a644f67c778468a8b62a9f2fa997dfeed8679a99750a17d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "253bd6ed9a267c01ab9491c7c4d66a756d6359e5234d48dec25ccf6bc6b0d333"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2a03923780e9300655bd811fd4e1621376a1a118f9f18a02801244191d2b3cf4"
    sha256 cellar: :any_skip_relocation, ventura:        "9ed0a25ecdeca2f1450a465a1be866d781a863ddc42f601f1f306daa9e266645"
    sha256 cellar: :any_skip_relocation, monterey:       "1cd351847e4c1ec475cd04ad248804473d5a0b0320509bafe155b7b08e3bbadc"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "547b153d41656cfb1928916b963c08dd4901594c835980a52d8811fa8e827a6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8317de3ef693fa78f3cc82b1ea8f34a0f5fadd75641de29a90658de15cb0b06b"
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
