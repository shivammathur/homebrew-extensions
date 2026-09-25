# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT86 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.3.0.tgz"
  sha256 "b7af055e2c409622f8c5e6242d1c526c00e011a93c39b10ca28040b908da3f37"
  revision 1
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  livecheck do
    url "https://pecl.php.net/rest/r/uuid/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "34b01d948805c8af75e76e922d568f246d90659eac13340f397f03bd1f2586a9"
    sha256 cellar: :any, arm64_tahoe:       "a2dcd37b24df3499a2f9193f2202060ef4d8618170048e178b4746c699566b3e"
    sha256 cellar: :any, arm64_sequoia:     "3ab6ade2ca1859931b1382cc780dbd4c8b14ad67528aa4827606f6e922822f00"
    sha256 cellar: :any, arm64_linux:       "90fa69d598308c082944e50c81de1b0130c3fab68dd740bced1d1b252843f518"
    sha256 cellar: :any, x86_64_linux:      "5bbbc075841a02fac2e17bef730d20bbd041bec55f0f6333e7e597495be72b49"
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
      --with-uuid=#{Utils::Path.formula_opt_prefix(uuid_dependency)}
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
