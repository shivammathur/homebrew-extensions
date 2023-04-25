# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT83 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.tgz"
  sha256 "988b52e0315bb5ed725050cb02de89b541034b7be6b94623dcb2baa33f811d87"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f1cec41d311e486b069224d6a8b418abb749767d1718cd1e2335e5860714501d"
    sha256 cellar: :any,                 arm64_big_sur:  "6acf13dbcc6cbc5d45fa0b2523d1fdfbe2fb1510f0f0694866618f33d0994917"
    sha256 cellar: :any,                 ventura:        "e8df29fee2417feac22429202d1210018c04e1631d3339ee511edbd9b7af3529"
    sha256 cellar: :any,                 monterey:       "c55a7b3f0e92be296523c450e88a73f646b40659148c6af117ee2c0cdad5f955"
    sha256 cellar: :any,                 big_sur:        "ea41f172b169328fe4195a10483bed07f281140ee1ebfb61b69da97ece1fbea6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c02b2d069c4e9cf74a211c0b68eeb76e6818e52a2bc4d821b16ada93d517d2f0"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
