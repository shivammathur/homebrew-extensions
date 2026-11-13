# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT87 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.0.tgz"
  sha256 "2342df367fb01a789a1b9f6c9c780f5221c51e9c00bf1cd1dd8a5c38b98d4cc5"
  revision 1
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "2289fea66507627e34327ece7892766e2b617d3cd40d9162236acfad11eb9ff8"
    sha256 cellar: :any, arm64_tahoe:       "b64a5329d8f533f46e01219e2104132ce06060130e98858f199f1413b487f25f"
    sha256 cellar: :any, arm64_sequoia:     "261c41be127f1f137870c55884902c4ea6871d6811273c482e97a0881914edd5"
    sha256 cellar: :any, arm64_linux:       "f4fc64d63d361498afea9bfee214dd25e35e6c5cbaf12afcb46df173ad04c92e"
    sha256 cellar: :any, x86_64_linux:      "fbab2f863c5e6560cdabf8fc0cd0cb2ccbff7631672203be912e0df3d7be1b01"
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
