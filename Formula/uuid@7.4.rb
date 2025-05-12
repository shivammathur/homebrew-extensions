# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT74 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.3.0.tgz"
  sha256 "b7af055e2c409622f8c5e6242d1c526c00e011a93c39b10ca28040b908da3f37"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  livecheck do
    url "https://pecl.php.net/rest/r/uuid/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4e6a57282357acc4cab070c98c81b85dc827a1b7fef6664aff97bd05a6c34694"
    sha256 cellar: :any,                 arm64_sonoma:  "acfad7c78b6ef2bfb41ce5de83cc551b1a73b7aa529ddb4417f1782cbbeb4451"
    sha256 cellar: :any,                 arm64_ventura: "1979671a1f3a985292ff7a973dc6967fba8aa2fb5a4b623e87dc475abdd630f5"
    sha256 cellar: :any,                 ventura:       "9b285f5223ab729143cd3208f0db3dbd4950b8f16c5b12c3ee310fde849c7b89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba5915f9eeefec7833298c2c861aa3459cb79c6cf4edeff00b97fac58b7520c3"
  end

  def uuid_dependency
    if OS.linux?
      "util-linux"
    else
      "e2fsprogs"
    end
  end

  on_macos do
    depends_on "e2fsprogs"
  end

  on_linux do
    depends_on "util-linux"
  end

  def install
    args = %W[
      --with-uuid=#{Formula[uuid_dependency].opt_prefix}
    ]
    Dir.chdir "uuid-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
