# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "7461f5b4e1586dc58ddf577229650416ab4d93f740aab4fe570ca8d86feed59a"
    sha256 cellar: :any, arm64_sequoia: "17e7af97b44ee37bec2b22595aeea1d15274bf4997dc1316ca7c27763b38bdd4"
    sha256 cellar: :any, arm64_sonoma:  "3143bb18aaeda97d8b3d5932e25767820ac46219b53ab3080a7d3ef3610474eb"
    sha256 cellar: :any, sonoma:        "e509b6e2a705a646b08de684c353302d43d93e85a187860fabfb70e003add264"
    sha256 cellar: :any, arm64_linux:   "2594dcda944744f371f7cc96475755715f9bf3d138eb27b0afc943464a9318fc"
    sha256 cellar: :any, x86_64_linux:  "476abf14cfdc72e089e787c89130792c74aa06dd39fb7499f9b9f8157995a2ef"
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
