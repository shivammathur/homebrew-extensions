# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "cfe0b0c64ab65ade220c6d234bf2937cfe017a9049fb8a9fdd5b8e77d90ca304"
    sha256 cellar: :any,                 arm64_sequoia: "62130e19ed6129cb4c2d91fcd13d7c70f562eb7beae5067bd4136bac949f672b"
    sha256 cellar: :any,                 arm64_sonoma:  "50c2515f31c362958a8cf2aef03253568beb3dac8e4eb493f8ef7081abd89e3e"
    sha256 cellar: :any,                 sonoma:        "7b86cf9ab686e63429d3f3790e4c232c7720bf0a064f8049861515f33ef2f40d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5b3f118f00d9dac53e23a73c82444876d50bf3ced7db063905dcec0d5e5bcd40"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b51582d5c6a779da9c9aa65738f124b82585e8dfda793d01545d5a9bdbce28b"
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
