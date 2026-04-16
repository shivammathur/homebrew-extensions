# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT74 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e5c57bd62eba4ff9024e5f3309b38699e22795c4f59e04f2da5b10df27e6166d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ea7ab340c8b7988e4d19d469b5e11fcd03243bddf1ba0966df6169409ff473b3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a0397a01baac134a911b68d58ced1813576c1a320505c3245757e5bf72ca451d"
    sha256 cellar: :any_skip_relocation, sonoma:        "052590b9de560a0ce89bcbcae307fde29e7db86bfb7c47d52031e0096c947ac5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e0dfd6cfca104a6c23c7125ff002ce3655b41d5c298a1d5e961beca8c2ab1b41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "baf995d3dfb9dae8cc7f62e826aacb9b49e8c4b486b21733fdf336219c9cb4a5"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
