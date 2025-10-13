# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "540fcb87679ca650f75f28135994339cc22dc08e15ccca8d77918c1e18808255"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "470ee26698401f13ff5e6f45c5501d9e60f39d8b1ac2727f719e4aa377630ddf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "90cc8c5c3d505f7bcb9caaddb415c7d831c04669c351d8465d4e196b5a8d2621"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "557be6d40f015ee892e38146ce46d067a9a9e96b27e624e588bf3bff091aef5f"
    sha256 cellar: :any_skip_relocation, sonoma:        "f8df4e2e396b7b7b8241935e9d47d78ffd7309559eb5744bc912e94a94b15792"
    sha256 cellar: :any_skip_relocation, ventura:       "bf9f1bdf80e89bbf26ece8dc9c4350ed760b58d087e674e1ad75b846bbdf0eeb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0ed6a7805e740b1a2fc45534292e031adc45a8709fae3c59d627596169d509ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a68106ee126f16b9fced2db793a4533531d3fe870b70ee377ebc02ccac715e2b"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
