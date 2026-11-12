# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT85 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.0.tgz"
  sha256 "2342df367fb01a789a1b9f6c9c780f5221c51e9c00bf1cd1dd8a5c38b98d4cc5"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "9421cb390721227cf10ddf9d83de49f87262badc853b1fcdbfb58c67d68d8a86"
    sha256 cellar: :any, arm64_tahoe:       "8dceab7e25c8595951656fbe48eb8212e97d27dc6491066b6fa5bb4f1dc313f0"
    sha256 cellar: :any, arm64_sequoia:     "a1216902783ea8e6f637eb2df9d9e667a67185df259d7e5b44201fc93baabf4f"
    sha256 cellar: :any, arm64_linux:       "d3c0072d5aa075320c3e5858dcd3a1fa4c7f79c4d1f4fa72894716e6002fb1de"
    sha256 cellar: :any, x86_64_linux:      "77b9d1ff5ffbc236c1d4b730cf08adfe77a201a1802fc313c6131e83b13ba46b"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
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
