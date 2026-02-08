# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT82 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "be2a5979be91d6689005df30bf8561ac1e1046f477540cb8d6812c96b3f4b7d2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8ddd6bd978d3b0e7cccc4004a7d1dddf25b1a573f7e8a3b125588812820ddbe9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4fe5c9b002f3295dac2454e555dda7616e8c72fb0deccfb2ab9161125cf44710"
    sha256 cellar: :any_skip_relocation, sonoma:        "54f376c50beac505c022a73d6014d48cd52f79beb84d7c789c41acca61e82069"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e29b55650816f153f1ada18f601a73103a589bad4a3d47cf0c2c9ddde77568f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d88d704f20138e9932a1e4786aee01a4cf482da6261c9e71d6b915b53106aca0"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
