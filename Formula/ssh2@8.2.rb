# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "64df6e2464229747287120032abb61d327b5a03f277e5a5497022228c9f3d864"
    sha256 cellar: :any, arm64_tahoe:       "521fb73404080b317b9ac2cf9c9ca617561eb6f94fb47619df2a284791b91504"
    sha256 cellar: :any, arm64_sequoia:     "adb4ea7c6d4b5e9154e4a2f25d1bc3a247a16d39fb6969bb9a8fb22ae326a215"
    sha256 cellar: :any, arm64_linux:       "119a72d5e9c5acc5ebf5c608d2bf3610694e5205b48a2f31720e0b2980d2971a"
    sha256 cellar: :any, x86_64_linux:      "20f87b8747aa2506565dfa81fbbd5b2be9d2b9a0ed58bedf6d2b4754c21b62eb"
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
