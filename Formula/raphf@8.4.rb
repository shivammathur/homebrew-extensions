# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT84 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3bcab391341fac2e6cb5913f66613f5c15e32fd65912f425231928941213d941"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7e3d05a300071e8b9f101da1ae5225afe50693c40ff8c8f2cb3b262a2779109a"
    sha256 cellar: :any_skip_relocation, ventura:        "0a5cdfbf38daf3c012a0ab03ec2a4ecb07c614a4c7d43e4de1ef44fdce661a50"
    sha256 cellar: :any_skip_relocation, monterey:       "a0ff0dbcee5a5626dc3ff6840632f513cbc0ecf113e42a4a28dbf6936bae5fba"
    sha256 cellar: :any_skip_relocation, big_sur:        "faf1a041b8528d8e61d56f55322fa673a53bc7451402a2d0433a406a22ee5cbc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3085008912ee3892e1ee8c59118dc0e1b52ce2f6f57f09e9a0cbf04339f92748"
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
