# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT83 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "eb4ae1d6fbd66dde8b597aa44a6f99c9b091f4093037fb667005c9157506ffc5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "68efed5431264014657b7880e4a3df76ca5251ae3ddaff195a271780fbb48d4a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ee3aefac542f6fe9707b37ef10990dc78eb1895422f9ac7ad27a47ef2c45cb47"
    sha256 cellar: :any_skip_relocation, sonoma:        "124b8a2aafa197cdb9c1e8035e50ee2bdf688e201d545918496efed2768bf59b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b13aa5047986d2d3f0c8d4a1c97ad3b73cad8f08fe685a508b84bc1c7c08abd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dd79b36f67ca6c80db5e3eb73e305664f2b7a9dc8e535bee9912ee10dbd940cd"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
