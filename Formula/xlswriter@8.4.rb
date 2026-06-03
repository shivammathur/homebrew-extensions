# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.2.tgz"
  sha256 "a85ce71f02eafb2617ab125b8c97677ec8b4eab3cd81f32478a5eb44fe55f145"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1aba72fb246131f2e32d5074fa1d9a1d27e88fc4b8829ea08a58cb8b60f58d55"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8a1849fe0ccbac3dbb65e8a69db663ebcfabfa53debe5cb1680861506e74032b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3500ba5e10d66e0935f803cb03af29e55391f6420c7df6b780ebd489b7afd2b8"
    sha256 cellar: :any_skip_relocation, sonoma:        "fda6798cf12a78e130d9b976640498389cfb758959debe7f501117fd4f0e2e30"
    sha256 cellar: :any,                 arm64_linux:   "84971b50aea137f68b217dbea0885b0a778a375caf7b1273a3d5f907d7cf7b84"
    sha256 cellar: :any,                 x86_64_linux:  "469dc05ee17ea30511817af75091eee68cbace6c4cdfd4f32d68c31ba58f59f6"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
