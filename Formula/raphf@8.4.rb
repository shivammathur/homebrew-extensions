# typed: true
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
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "fcf6fc807c39d1f9dc969ded45ed5e8f4dd2de919c71191ce9b68e7679ed1061"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a7d75e26268959b700023d7ced07b8d60d93a67fc2fd862ee5cd63be187548aa"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d4399e42cdff737d318720ea9f33ef1bd224b8b99425dea7a735a55883bb0805"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "13706a5101c76df10791adffb297b3887134f50bf7c6cb4eb53c43e72cbd25a0"
    sha256 cellar: :any_skip_relocation, ventura:        "c8c7752db667eb40e30e964ed4d76e6f1bcc5226a9250c423c27625c4cad1a7c"
    sha256 cellar: :any_skip_relocation, monterey:       "23b9debe51810f07717f841d46dd913edc2566e4127ce7edb3f8d0be8e86e07e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8778f6431c1d433ed61c211eebb1fff113605d2cd45ab1818773e67baf4f66d3"
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
