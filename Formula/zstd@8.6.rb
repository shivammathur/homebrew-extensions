# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT86 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  revision 1
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "3da42175f638481be9ba31489bac03128175f1939bd309171a10b6ad344b63d4"
    sha256 cellar: :any, arm64_tahoe:       "ff6ebb24cf31c7b6babd71d24f0e6b1b4ee9ad0764b1500e2117d082139a0ea6"
    sha256 cellar: :any, arm64_sequoia:     "017374153d89901d0942cb2437ff247bb0a8a30d98ae88e9568417445e87fcf6"
    sha256 cellar: :any, arm64_linux:       "28ad778bb972bfd1a5a0ad880a6244b986a86a48c49acc9e8a974f1264ca8532"
    sha256 cellar: :any, x86_64_linux:      "1efba8b25722b1e018a3b89682d7211b3476d09ce9a211182ee6d043c39c8077"
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
