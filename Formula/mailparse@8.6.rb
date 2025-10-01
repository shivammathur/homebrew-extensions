# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT86 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.9.tgz"
  sha256 "ecb3d3c9dc9f7ce034182d478b724ac3cb02098efc69a39c03534f0b1920922b"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b23a5531f06ebf8cd4d10a2126371314a84089cc736c226fd46af33725e041f2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "705713e515d9153d0b561e72ee979b3f14a5884fd7548b353b7223f0c5085539"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "21102ea3269a3e6aab1e7d99ab94ab428445dedb25ed35b8965d7164da8b9664"
    sha256 cellar: :any_skip_relocation, sonoma:        "a673402f073ed9aca436f78db1b80da3fd196f005a250db049f8cc1021d56b25"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4c4bae9f527c77f08e87c6ea26b653ef7a11de75624126feb3e4c25bf5dbc511"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba81a0d92a7e9eb4196dfea7d177b5511fc4c38c36c04cf280788e853658f9ed"
  end

  depends_on "re2c" => :build

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
