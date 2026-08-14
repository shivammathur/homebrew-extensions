# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT80 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "01786cc5d631fbf68ff1560771db230b3d3ccaa293967e0366f545b2f51f9efc"
    sha256 cellar: :any, arm64_sequoia: "5a488a13cc885ac46015512f0172409244313306f11b387d9bf5a65d50478c59"
    sha256 cellar: :any, arm64_sonoma:  "eee59fa61160a3f65c6fd78db86889f766bf105ceca4f8b8253c8f3441c89874"
    sha256 cellar: :any, sonoma:        "d1660285fda9a325058c4f5ad3759b9d41c50f4f417aa92a961fa7d49a34e21d"
    sha256 cellar: :any, arm64_linux:   "75cce3dd81724b41229a431e188cca2bac0fd3e144ab19fb17135eebbd6e967a"
    sha256 cellar: :any, x86_64_linux:  "a7a5a8231c6a6ba51c0789fc19db88b2f64b10f487d13e81782fcb60c6bed845"
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
