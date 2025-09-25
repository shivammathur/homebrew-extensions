# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT85 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  revision 1
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "692075a8d60818f81292af701e96b56eaf1e8d2f3c8bfad98e4c5e353f8a342c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "299ebeae875dc9cb1351be91bea082bdb7709473517ffb084d16f04e2201700a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a210475abddb2dc016403a87fe597d59c1aa36dcaf97063e4dabf3067d1b289f"
    sha256 cellar: :any_skip_relocation, sonoma:        "a305703f5472bfa5dd2098226e3861cda4c71d7884bfbe806981edf5b573a441"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bbcf6c01fb4f6ae1dee6e87ef0ac03db76fd177f2536cb59ff8011fd03ec09bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "24b90d29e29642af19342e9fecd47df4a167e7d97f622a6c83021b52726137c4"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
