# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT73 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-2.0.2.tgz"
  sha256 "2c63ce727340121044365f0fd83babd60dfa785fa5979fae2520b25dad814226"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "13953d0a993065500c74ef286d1167af305787c00447b6c677cc41158e26a06e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "aff36eb4889eabf26c73c2ff9f50d37779bac7400b573986e77411bd2eabe1bd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fdd8160e73be869b7736d8fda65c32cb3fb25b63c166b5ac0578a7c3f88b20ba"
    sha256 cellar: :any_skip_relocation, sonoma:        "138caffd28be26b552a6b4a8c99c02deca972fb64e34dffe1311f6dc74f6daef"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "46a4982fb8a6dc2efc702afe7d66c679676cca28b1d3f124a9b991a760ba8ce6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7b5056ed89a2b19added10074c108c17da9d70b65cae20b1ac0fe499ba7c2238"
  end

  def install
    Dir.chdir "uploadprogress-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uploadprogress"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
