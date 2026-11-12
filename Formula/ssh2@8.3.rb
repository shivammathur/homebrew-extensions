# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "5386de8b090a9129f69a600675f0fed837188fda13611724f861c19fba569622"
    sha256 cellar: :any, arm64_tahoe:       "d7c027017faa58297ffff005a83defaa12600c727f3f4ea962021ac3eabfcdaa"
    sha256 cellar: :any, arm64_sequoia:     "8b8c4e13ba74930c1b8d6cbcf5283d9f1b7e5fabeaaa8df5425dad2806b5c3ea"
    sha256 cellar: :any, arm64_linux:       "0c05485158eec46202a694bd11af82c38dd0b2be9feca3f5f9a2a9315bee89bd"
    sha256 cellar: :any, x86_64_linux:      "0fee1d70ad8f29299b64a4f04f08df3ecc34cb3d1389f8295cf0b273391bc99a"
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
