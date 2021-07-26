# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT71 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c53241b6c9384ef7be52986c5ee4a15373b05f443813396b2d906ab474f975fd"
    sha256 cellar: :any_skip_relocation, big_sur:       "76586768a37804f9cb9077e29000e8c077ead5c1f00acb7fef6f89a6cd0f5302"
    sha256 cellar: :any_skip_relocation, catalina:      "3e886d17eb0202b60ad5dcb4ad1c51359e01a8aa394f70b1cd7baa51a56e9a11"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "05c3a43107f8a8dfc0d399befe05cdf56c44297a717bedea72616751af6b1b43"
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
