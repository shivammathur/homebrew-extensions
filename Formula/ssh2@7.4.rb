# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT74 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.5.0.tgz"
  sha256 "a943427fae39a5503c813179018ae6c500323c8c9fb434e1a9a665fb32a4d7b4"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6e7406998e14fb01a5c0652f4eb8fab5f50b98d8ca4c1e0e52a6b108e9dbd424"
    sha256 cellar: :any,                 arm64_sequoia: "46e58d3bdd669b183760e6d90b2a8e2a0c8bacca2799690635d4ba0065b9d6d0"
    sha256 cellar: :any,                 arm64_sonoma:  "5ec34b894f839f798c6492e0550d219c1cc63a0a1026a36ddc709fc0a6f60f21"
    sha256 cellar: :any,                 sonoma:        "ec1a3ce9d13dda89f4e9a581fa2b4abb84d0e8bb9e6f9aed22131447fb1d01f1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ed8d0cf9da96b76d750859e3a540e126e4a588c0aee94265c93a534ad98fee54"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "809ef2aad859bf4567d17e5526fcd32a1552e0da526b4f18b17e3b781a84fe78"
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
