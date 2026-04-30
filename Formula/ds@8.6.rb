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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d593d4f5ecff0a09f0d9017749d68b5279443467e299aeaacefc58afe8d0d44b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f28c639591a4ffa71572ac404c5f4dd09b7a7592113e92e9c50e965cf8004585"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "caa313ae1b3a6d2139e49e3235a472856690a4e4aa306a35f085f2318c2f6fe6"
    sha256 cellar: :any_skip_relocation, sonoma:        "6b7db12bd5cc0af3a0f12e19bfd8f85dea9b9265216b7a801f2c0cd467363816"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7b1f556405ebba6264d28939479750c9e865ce58dff3bafb0fc723c96ec17d4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1e8558565e91594309410e790754113baf81e56f2af8c6da2d8416b4decfee5"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    Dir["src/php/**/*.{c,h}"].each do |f|
      next unless File.read(f).include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof"
        s.sub!(/\A/, "#include <stddef.h>\n")
      end
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
