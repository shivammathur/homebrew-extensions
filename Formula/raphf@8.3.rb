# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT83 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c5982543cb55ce2373e61f35b7dd5f8f2132a3d70a928a212ba6489a589f5671"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "adee00b06909e2a0d2e41ec6e87d52dfe557f23a9f8cfe06ff3092962327061c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b34476500a21c1a297053aa1ce0375ebb06b560d153ea801bc59f2bf45e29353"
    sha256 cellar: :any_skip_relocation, ventura:       "506be1059fbb4d03cb90c099f29287fc24c0f3860419d3051cc19e42447278a5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c5cdf13e55c50283a882432a1eab2356367a9572863aca3a38189c55adaae4d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0acd814a57f29fb3991ee6d5f37272d167ae63218a300fe0b427bf22a3577441"
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
