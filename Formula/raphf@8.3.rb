# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT83 < AbstractPhpExtension
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
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2946c1c8d9c62a7ba57791acc8c6bb318529d2c4dc072e405414bf3a7ccab022"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c4b5197ad46c0138090e28003696250fe46f42854ee059968cdd307ebeec7a7d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "92d546ba260b26b3c2695b8a1fd4d92119f0ca619633d9f0f0d6267053a551ac"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4d2481ae970c39cf927fdec9b208a2152240d38eeb6ee3d002094637bb777f7a"
    sha256 cellar: :any_skip_relocation, ventura:        "53366352f4e20424fa344362422b610218df4a79671f866618256f3c1fcb8d84"
    sha256 cellar: :any_skip_relocation, monterey:       "ad2446880f4afecc47be8ea6bfd41277a248c8a92c1330711f15564e8959e49a"
    sha256 cellar: :any_skip_relocation, big_sur:        "e322690258b1fe333a3418a1bd1928d4fab6c5ce40fa9ecfdee88e87477950ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "439407c93890ca6a5a427110366692157251d1b996d397d52d02d59b5fb2151d"
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
