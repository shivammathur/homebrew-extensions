# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT70 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-5.0.2.tgz"
  sha256 "74bfb68c7f88013be6374862eed41b616e0bd6aa522142ccf3394470d487d5c9"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a18e670765839bacc42c00bbb2bf9f3d63bb1ee25e101157879f381d467095e2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f1da6e02d432853f175eecd7fe54253e44fdc1a08854bec11e53bd842590004d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ea000c7c2b73648a45d41502b33b1a9a07a7d0f127ab37d05d156a5a2cbc5f34"
    sha256 cellar: :any_skip_relocation, sonoma:        "fb36c81d6acb7e8855b878c704f32fb8b21ef87c478f53f864444a8a75000158"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f4c33bcf26b3dc4f6fa3d5e8280b3e9cd55299acec6e1ba4da6470a13cc44ebd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2526b06b1b656b8d6a86cb41b54549e449c1cc3690358ebdc8f7a8648187898"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    inreplace "src/function.c", "static inline uopz_try_addref(zval *z)",
"static inline void uopz_try_addref(zval *z)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
