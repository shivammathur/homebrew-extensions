# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "e20d2877bd587b67351bd128b9877665aa5ff6355f4014d2b397d6a3b9d3e274"
    sha256 cellar: :any, arm64_tahoe:       "fe7cc661b87f5f85b83e3a9e807604885e33ed1ebc7600041f6dfb650e027862"
    sha256 cellar: :any, arm64_sequoia:     "95a4a3d383e0e8ad56ad4e749bc64649366d725bf36c8f1acb2f39c4012808cb"
    sha256 cellar: :any, arm64_linux:       "8e18dcee95ba32e9446bc70b70ea182b39bb05ea016379bb425f6ff61ab6502e"
    sha256 cellar: :any, x86_64_linux:      "17c4e0d05d5606e0219cc4f5797c25eca038b4ea295bc2fb0e358b22190917df"
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
