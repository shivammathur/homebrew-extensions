# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT85 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  revision 1
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "60dff7c80884e1d8aae0eb1e94a902ece5dd5e818b160f7f42ee3af9a85dfe11"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "319d74e66d4f9916b230557f8784e8dbbbe922d4b2c3c4e8c45479de229b37d9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8f3111db049cb2c8062c0f7446191373ddb02b6e3528c3a9d3a1d88fdb58e087"
    sha256 cellar: :any_skip_relocation, sonoma:        "d44d53426fe316349098a22579bd7a077f3b33dcbfa144794551c13e2068bae4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a909b0c1f60cd3da6fc2c7e2720dfa2b960a204e89e9ddc46fd5ca0dc30f2b9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f31af55384fa4fe40fd63d0df1a4fd69dd23ec22dfa1ed04999f64ccff4d8e1"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
