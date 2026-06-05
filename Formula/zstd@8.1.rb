# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT81 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.16.0.tgz"
  sha256 "3d5bfdd1c70b0e3e892461fca3bc74e899322c69404b706fec27af8118d9bf99"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "1c670c639c6940d6dd6f2bad6297f9077adf32f182cd714e6622603bc4476ab1"
    sha256 cellar: :any, arm64_sequoia: "f3503ba1219d024c917286465f0062eaa3e1f0cf4c74fb7354b8c13dea798e14"
    sha256 cellar: :any, arm64_sonoma:  "af9e2316d31346a63e3097967737df5157b2749ca5dcafe20847a33b34c65e59"
    sha256 cellar: :any, sonoma:        "b13f848403439acb45f9b46c92e2c1d39712adcbb3c8b0619e07dc33cf24e531"
    sha256 cellar: :any, arm64_linux:   "71b84e1b22477a9cf366054da6c1a09dc39e791c379bced16c1b6741d7122506"
    sha256 cellar: :any, x86_64_linux:  "b5eff1385664b3ed1e327ded90d5ed0edfd8b903b6da2e694070425b40a2dd0d"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
