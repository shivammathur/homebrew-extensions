# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT72 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b6fc0c220a75384aad4dbbb80e53fea3105c7448e586bfe0a0be806bd1b1335e"
    sha256 cellar: :any_skip_relocation, big_sur:       "4fdac471855ed81bcc3f4cbf5d18e8d87b1e7a30077d1fb989e8c899497cd891"
    sha256 cellar: :any_skip_relocation, catalina:      "98fd7b39a11c90fba3d60e2287eca11daccdca90fdec9475295d17ddba2c832c"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
