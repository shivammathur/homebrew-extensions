# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT82 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-2.0.0.tgz"
  sha256 "52dfed624fbca90ad9e426f7f91a0929db3575a1b8ff6ea0cf2606b7edbc3940"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cd23ba9d50ef7b4fbff83b5287f55b03aa5c8dfd178e1478dfae651bfed5efce"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7cf8d3f245256736b124ec593b9d0d2375f31391a0c621a8d7fc09df373d3262"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "83bdec7ce2cfe53cc69ad15828be4a8ef14673ba91d2cda12f39364f816ae209"
    sha256 cellar: :any_skip_relocation, sonoma:        "31d5e3d02737a875122212946eeb3704ba33e63362e90f81d98ad2a67774ffe4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f2f5c7ffb3dbbfe2be3d68af8889fed944d8e6efcab48c608205a2e2d86b01a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fe4c422bd03ccfcb5843611eb1d056a9190edac0ec7cccb75875e5157488b101"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
