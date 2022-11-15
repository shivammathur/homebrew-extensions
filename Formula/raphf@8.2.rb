# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT82 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3d03cccf0f2485b19e4a8aa08826b30d0ed2dacb262884b59e0cc35ed315ac14"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f10859fb0ca81ddd3e190aa32113f0ffe0adf726ec2c62bab68c4f6cae7d805a"
    sha256 cellar: :any_skip_relocation, monterey:       "9133c576a16440f61806571878e2303a1ded4943299c2a1bb2ca946d87b1220c"
    sha256 cellar: :any_skip_relocation, big_sur:        "eee00000386f40a7d5e2a430c97e159bb316a522d13c4e76e9ab2c7fb1e86030"
    sha256 cellar: :any_skip_relocation, catalina:       "30cad7b2b3da51157ec5371b5fdf3ee4ece148b8fddd485a578dc08a3abc5d89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1adc268230db464325cfa5a75cdcac4ddafcda792b19e69e7cc08944f58441d5"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
