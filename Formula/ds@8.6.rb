# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ec244f5ad0e9f8fd3b946a8c4f2d7e19514db941718bcbbce89c3786173d30c7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "53abdb7f23e9eab2a79a7f1cf3c66e8b45f68437949f5af0906f65b32f1173d6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7758be4339329de9da07866327bb91e04d25e2c62ce2c244d6310743017f185c"
    sha256 cellar: :any_skip_relocation, sonoma:        "81bbed9fc62654b5fd77ce4ba47f6c0699b55b5ddb3abc4fb70252a0c3979a82"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8cbf0048955129c013c210f107678963a17900d79a8d5fcb8c1b76441436b9c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "51821d196de43df06e29114839279019b3aca4e8e2cc72225835fbbef032b75d"
  end

  priority "30"

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
