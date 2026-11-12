# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "26996c1c4e06915629339fe72be517a3d9fd7e17894c839a09aa3506539d04ed"
    sha256 cellar: :any, arm64_tahoe:       "f066ac3156e4774bea6c5d5aed873b56a6f92380c4d841d852962ec54282fcb0"
    sha256 cellar: :any, arm64_sequoia:     "01e6fef05b2b59eda40a4599d10a8c2220249dcf1dbd8c039295a65c48d727e8"
    sha256 cellar: :any, arm64_linux:       "996bde01ecd1cfce6d1d1ebd658ca63dd6631bcfa93666d3b8203762fb1573b7"
    sha256 cellar: :any, x86_64_linux:      "9fcacd228624a13ee8a9bc925ef390e76d9f7fc9ea310b52a8caea220e7215bc"
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
