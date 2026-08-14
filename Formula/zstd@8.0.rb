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
    sha256 cellar: :any, arm64_tahoe:   "f1859354db397c3e327e5f97aeaed5a4d62b168d6ea53904ee633248cd543bcd"
    sha256 cellar: :any, arm64_sequoia: "0c01f3d90bf53b2b3ef0d23f7c89dfbc5b3deaec5fab4823c7a6bb5894f9ee81"
    sha256 cellar: :any, arm64_sonoma:  "be7d05ee52b4aa3318c5b1e69f0b7e1c695523cf866db1bbe9b61530d21288f9"
    sha256 cellar: :any, sonoma:        "5077258babe60f4f8f0ab5c8d34521994f9d0777c994b995f0d22c6860da2a65"
    sha256 cellar: :any, arm64_linux:   "f2fd58586028ac0602c489dac9c7d12aa80870f015ecda7765843fe2b895a3b1"
    sha256 cellar: :any, x86_64_linux:  "defd1d0f13a30e96938b38b3fb88832d20bdf79328b1f171dd92f736459461e4"
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
