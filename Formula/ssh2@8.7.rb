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
    sha256 cellar: :any, arm64_golden_gate: "33cd3498349d9fb09dab87bffc4997511f10f94569c6a728a9462c2292b8315c"
    sha256 cellar: :any, arm64_tahoe:       "34dbf8e1988b18cb18e0872575d95a36336fbc43b0081eb7238d96cd840027d9"
    sha256 cellar: :any, arm64_sequoia:     "8e84ad595236ec0a121c83cbfd1fbf9b73fbd5985a03012667cd3a25f4f41e97"
    sha256 cellar: :any, arm64_linux:       "2fdf195aec125111ec91738c43c302478d11792d5c9564a9451ae853d3e4d69b"
    sha256 cellar: :any, x86_64_linux:      "175fe79c9e0a069357b28c9d53f56208ce4c865c1835c722c4f13759b89e0c62"
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
