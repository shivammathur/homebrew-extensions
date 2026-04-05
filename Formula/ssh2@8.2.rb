# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "0e0fda1a856fab01a6059d89fc4a4ce7436f47915907167154156562b176f319"
    sha256 cellar: :any,                 arm64_sequoia: "f8fc027b1724d5bc9ec2fa1005a5748493de4f38d420e95645b60195520b4fb1"
    sha256 cellar: :any,                 arm64_sonoma:  "f91006f6a45fcd615a71e731e1e069ee31c750cf481f20a17b7399d7ed64108c"
    sha256 cellar: :any,                 sonoma:        "7d903f784b1b5f80b0f508226165fd64b394a4e16b5e5cf7f81a53db3ed39fba"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f458c1d702a86134dad7f4c16a2a8eb096ac466a8f3b8fbb6dcf378552aac6e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9afe2174a0ba079d872046591d6e98511571948561ba9249adf05b8d74eee634"
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
