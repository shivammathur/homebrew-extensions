# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "744065684e0bf2c6bade430cd12bf06e8febb8061d2c34230d7ca4030037d437"
    sha256 cellar: :any,                 arm64_sequoia: "75cd792727c32e5f8791ffd1fc8599d0a7e0c9f3299d19b7d4e2d747e0f99e2b"
    sha256 cellar: :any,                 arm64_sonoma:  "96288a05a84609b1c320b0e44e15d1a12c2c2ab322ab6c44be7c82d14f60bd51"
    sha256 cellar: :any,                 sonoma:        "ad0662c8ca81704f051ef7056dea10cda3e418147477d83d63cc409a68e24ed8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b9a07af507a3f23d6ac0cc40c09a3b5452dd4dc16092d911b81e3524447cc333"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "632344629eebf8cd16e3fba59d1f60e9b15f1a09127454f7054ccddc32175e39"
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
